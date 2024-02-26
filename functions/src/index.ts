/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

import { onRequest } from "firebase-functions/v2/https";
import {
  VertexAI,
  HarmCategory,
  HarmBlockThreshold,
} from "@google-cloud/vertexai";
import "dotenv/config";

const location = "us-central1";

exports.prompt = onRequest(async (request, response) => {
  const projectId = process.env.GCLOUD_PROJECT_ID as string; // Assuming GCLOUD_PROJECT is a String env var
  const vertexAi = new VertexAI({ project: projectId, location });
  console.log("project", projectId);
  // Available models: https://cloud.google.com/vertex-ai/docs/generative-ai/learn/models
  const model: string = "gemini-pro";
  // Instantiate models
  const generativeModel = vertexAi.preview.getGenerativeModel({
    model,
    // The following parameters are optional
    // They can also be passed to individual content generation requests
    generation_config: {
      // Test impact of parameters: https://makersuite.google.com
      max_output_tokens: 2048,
      temperature: 0.9,
      top_p: 1,
    },
    safety_settings: [
      {
        category: HarmCategory.HARM_CATEGORY_DANGEROUS_CONTENT,
        threshold: HarmBlockThreshold.BLOCK_MEDIUM_AND_ABOVE,
      },
      {
        category: HarmCategory.HARM_CATEGORY_HATE_SPEECH,
        threshold: HarmBlockThreshold.BLOCK_MEDIUM_AND_ABOVE,
      },
      {
        category: HarmCategory.HARM_CATEGORY_SEXUALLY_EXPLICIT,
        threshold: HarmBlockThreshold.BLOCK_MEDIUM_AND_ABOVE,
      },
      {
        category: HarmCategory.HARM_CATEGORY_HARASSMENT,
        threshold: HarmBlockThreshold.BLOCK_MEDIUM_AND_ABOVE,
      },
    ],
  });
  
  // Extract meal preferences from the request
  const reqBody = request.body;

  // Construct a prompt using the meal preferences
  const prompt = `Suggest 5 meal options for a person with low income living in Dallas with the following profile: 
  ${JSON.stringify(reqBody)}. Each meal option you come up with should have a cost that is exactly the budget provided. 
  You must taken into consideration the available utensils and kitchen appliances available for the user when coming up with the meal options. 
  You should also take into account the number of people this meal is for, and show the calories and nutrition for the meal accordingly. 
  You should also create meal options that are easy to prepare and can be made within a very reasonable amount of time by a begineer cook. 
  Respond in the following json format only. The values are strings and need to be in double quotes.
  {
    "mealOptions": [
      "meal1": {
        "name": "meal name",
        "cost": "cost",
        "calories": "calories",
        "protein": "protein",
        "timeToCook": "time to cook"
      },
      ... same for all 5 meals
    ]
  }
  `;

  console.log('this is my prompt', prompt);
  
  const req: { contents: { role: string; parts: { text: string }[] }[] } = {
    contents: [{ role: "user", parts: [{ text: prompt }] }],
  };

  let result: string;
  try {
    console.log("Non-Streaming Response Text:");
    // Create the response stream
    const responseStream = await generativeModel.generateContentStream(req);

    // Wait for the response stream to complete
    const aggregatedResponse = await responseStream.response;

    // Select the text from the response
    const fullTextResponse =
      aggregatedResponse.candidates[0].content.parts[0].text!;

    console.log(fullTextResponse);
    result = fullTextResponse;
    // result = content.response.candidates[0].content.parts[0].text!;
  } catch (e) {
    console.log(e);
    result = "failed";
  }

  response.send(result);
});

async function generateContent(model: any, prompt: any) {
  const req = {
    contents: [{ role: "user", parts: [{ text: prompt }] }],
  };
  const responseStream = await model.generateContentStream(req);
  const aggregatedResponse = await responseStream.response;
  return aggregatedResponse.candidates[0].content.parts[0].text;
}

exports.getRecipe = onRequest(async (request, response) => {
  const reqBody = request.body; // Assume mealName is passed in the request
  const projectId = process.env.GCLOUD_PROJECT_ID as string; // Assuming GCLOUD_PROJECT is a String env var
  const vertexAi = new VertexAI({ project: projectId, location });

  const model = "gemini-pro"; // Replace with your actual model name
  const generativeModel = vertexAi.preview.getGenerativeModel({ model });

  try {
    const prompt = `
      You are an expert chef who specializes in creating highly nutritious and tasty food. 
      Your client is a person in poverty from Dallas, and needs your help to create a set of ingredients and a 
      list of instructions (recipe) for creating a meal. You can assume that the client only has a stove, and few pots and pans. The details of the person's profile, 
      and the meal name is included in here: ${JSON.stringify(reqBody)}. 
      Respond with a list of ingredients needed for cooking, and the step by step instructions to cook it. 
      Respond in json format only. Structure it in the following format:
      {
        "ingredients": [list of ingredients for cooking the meal],
        "cookingInstructions": [step by step instructions in a list for cooking the meal]
      }
    `

    console.log('this is my prompt2', prompt);
    const res = await generateContent(generativeModel, prompt);
    console.log(res);
    response.send(res);
  } catch (error) {
    console.error("Error generating recipe details:", error);
    response.status(500).send("Failed to generate recipe details");
  }
})