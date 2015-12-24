use v6;

# TODO -- Pull the following from config instead
our $port = 7041;
our $target_tics_per_second = 24;
our $ten_tic_seconds = $target_tics_per_second * 10;
our $game_hour = 60 * 5 * $target_tics_per_second; 
our $maximum_wait_time_in_milliseconds = 1000 / $target_tics_per_second;
our $begin_time;
our $time_elapsed;
our $tic_leeway;
our $which_tic = 0;
# TODO -- and/or accept command line arguments as override

# MAIN GAME LOOP
our @command_buffer;
start accept_player_commands();
while (1) {
  $begin_time = DateTime.now().Instant; 
  process_player_commands();
  calculate_game_events();
  report_events_to_player();
  my $time_elapsed = (DateTime.now().Instant - $begin_time) * 1000;  
  #my $tic_leeway = ($time_elapsed / $maximum_wait_time) * 100;
  #say "game tic elapsed with a process usage of $tic_leeway\% ($time_elapsed milliseconds used out of $maximum_wait_time)";
  sleep( ($maximum_wait_time_in_milliseconds - $time_elapsed) / 1000 );
}

sub accept_player_commands {
  say 'accept';
  react {
    say 'react';
    whenever IO::Socket::Async.listen('localhost',$port) -> $conn {
      say 'whenever';
      my $bs = $conn.Supply(:bin); #chars-supply;
      say "bs = $bs, conn = $conn";
      $bs.tap(-> $command { 
          say $command;
          await $conn.write: $command
      } );
      $bs.wait;
      say 'wait';
    }
    say 'end whenever';
  }
  say 'end react';
}

#sub receive_and_respond ($conn, $command) {
#  push @command_buffer, $command;
#  $conn.write: "received: $command";
#  say "received: $command";
#  return 1;
#}

sub process_player_commands {
  # process player movement request
    # is player restricted by constraint ?
    # is player restricted by conflict ?
    # is player restricted by lack of pathway ?
}

sub calculate_game_events {
  determine_if_game_hour_has_passed(); 
  # process ongoing registered incidents
  # process creature movement request
  # process climate change request  
}

sub report_events_to_player {
  # print incident report to screen
  # if player requested movement AND movement allowed
    # report arrival at new room
    # report presense of creature in new room
    # report presense of ovbject in new room
    # report important climate information
    # report alteration in climate information
  # otherwise, report failure to move to new room
}

sub determine_if_game_hour_has_passed {
  $which_tic++;
  unless $which_tic % $ten_tic_seconds {
    say "$ten_tic_seconds tics (10 seconds) have passed"
  }
  if $which_tic == $game_hour {
    say "A game hour ($which_tic tics) has passed";
    $which_tic = 0;
  }
}
