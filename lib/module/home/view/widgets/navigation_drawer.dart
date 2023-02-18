part of '../home_view.dart';

class _NavigationDrawer extends StatelessWidget {
  const _NavigationDrawer();

  @override
  Widget build(BuildContext context) {
    final photoUrl = context.read<AuthenticationBloc>().state.user.photoUrl;

    return NavigationDrawer(children: [
      AspectRatio(
        aspectRatio: 1.25,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 40,
                backgroundImage: photoUrl == null ? null : NetworkImage(photoUrl),
              ),
              const SizedBox(height: 20),
              Text(
                context.read<AuthenticationBloc>().state.user.username ?? 'Unknown',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              Text(
                'ID : ${context.read<AuthenticationBloc>().state.user.id}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
        ),
      ),
      ListTile(
        leading: const Icon(Icons.logout),
        title: Text(
          'Log out',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
        ),
        onTap: () => context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested()),
      ),
    ]);
  }
}
