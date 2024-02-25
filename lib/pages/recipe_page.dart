import 'package:flutter/material.dart';

class RecipeDetailsPage extends StatefulWidget {
  final List<String> ingredients;
  final List<String> cookingInstructions;

  const RecipeDetailsPage({
    Key? key,
    required this.ingredients,
    required this.cookingInstructions,
  }) : super(key: key);

  @override
  createState() => _RecipeDetailsPageState();
}

class _RecipeDetailsPageState extends State<RecipeDetailsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Details'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Ingredients'),
            Tab(text: 'Instructions'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          IngredientsView(ingredients: widget.ingredients),
          InstructionsView(instructions: widget.cookingInstructions),
        ],
      ),
    );
  }
}

class IngredientsView extends StatelessWidget {
  final List<String> ingredients;

  const IngredientsView({Key? key, required this.ingredients})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: ingredients.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 10.0),
          child: ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text(ingredients[index]),
          ),
        );
      },
    );
  }
}

class InstructionsView extends StatelessWidget {
  final List<String> instructions;

  const InstructionsView({Key? key, required this.instructions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: instructions.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(child: Text('${index + 1}')),
          title: Text(instructions[index]),
          subtitle: const Divider(color: Colors.grey, thickness: 1),
        );
      },
    );
  }
}
