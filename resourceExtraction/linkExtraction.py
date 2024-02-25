import json
from bs4 import BeautifulSoup


def convertHtmlLinksToJson(inputFileName, outputFileName):
    # Read the HTML file
    with open(inputFileName, "r") as f:
        html_content = f.read()

    # Create BeautifulSoup object
    soup = BeautifulSoup(html_content, "html.parser")

    # Find all URLs within anchor tags inside list items
    urls = [a.string for a in soup.find_all("a", href=True) if a.parent.name == "li"]

    # Convert list of URLs to JSON format
    json_data = json.dumps(urls)

    # Print or save the JSON data
    print(json_data)  # For printing to console

    # Save to a file (optional)
    with open(outputFileName, "w") as f:
        f.write(json_data)


convertHtmlLinksToJson(inputFileName="links.html", outputFileName="links.json")
