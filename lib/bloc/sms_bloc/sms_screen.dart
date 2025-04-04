import 'package:spam_delection_app/bloc/sms_bloc/sms_bloc.dart';
import 'package:spam_delection_app/bloc/sms_bloc/sms_bloc_event.dart';
import 'package:spam_delection_app/bloc/sms_bloc/sms_bloc_state.dart';
import 'package:spam_delection_app/globals/index.dart';

class SmsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SmsBloc(),
      child: Scaffold(
        appBar: AppBar(title: Text('SMS Reader')),
        body: BlocBuilder<SmsBloc, SmsState>(
          builder: (context, state) {
            if (state is SmsInitial) {
              return Center(
                child: ElevatedButton(
                  onPressed: () {
                    context.read<SmsBloc>().add(StartListeningSms());
                  },
                  child: Text('Start Listening'),
                ),
              );
            } else if (state is SmsListening) {
              return Center(child: CircularProgressIndicator());
            } else if (state is NewSmsReceived) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('New SMS Received:'),
                    Text(state.message.body ?? 'No body'),
                    Text('Sender: ${state.message.sender ?? 'Unknown'}'),
                    Text('Date: ${state.message.date.toString()}'),
                  ],
                ),
              );
            } else if (state is SmsError) {
              return Center(child: Text('Error: ${state.error}'));
            } else {
              return Center(child: Text('Unknown State'));
            }
          },
        ),
      ),
    );
  }
}
