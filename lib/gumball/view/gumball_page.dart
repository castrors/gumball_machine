import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gumball_machine/gumball/bloc/gumball_bloc.dart';

class GumballPage extends StatelessWidget {
  const GumballPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GumballBloc(),
      child: const GumballView(),
    );
  }
}

class GumballView extends StatelessWidget {
  const GumballView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gumball Machine'),
      ),
      body: const Center(
        child: DisplayMessage(),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              BlocProvider.of<GumballBloc>(context).add(const InsertCoin());
            },
            tooltip: 'Insert Coin',
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            onPressed: () {
              BlocProvider.of<GumballBloc>(context).add(const TurnHandle());
            },
            tooltip: 'Turn Handle',
            child: const Icon(Icons.rotate_left),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            onPressed: () {
              BlocProvider.of<GumballBloc>(context).add(const RemoveCoin());
            },
            tooltip: 'Remove Coin',
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}

class DisplayMessage extends StatelessWidget {
  const DisplayMessage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = context.select((GumballBloc bloc) => bloc.state);
    return Column(
      children: [
        Text(state.count.toString(), style: theme.textTheme.displayLarge),
        Text(
          state.status == GumballStatus.unlocked ? 'Unlocked' : 'Locked',
          style: theme.textTheme.displayMedium,
        ),
        Text(
          state.message,
          style: theme.textTheme.displayMedium,
        ),
      ],
    );
  }
}
