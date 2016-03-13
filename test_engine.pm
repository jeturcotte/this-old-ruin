use v6;
use lib 'p6lib';
use Game;


# TODO -- Pull the following from config instead
  our $port = 7041;
  our $target_tics_per_second = 16;
  our $ten_tic_seconds = $target_tics_per_second * 10;
  our $game_hour = 60 * 5 * $target_tics_per_second; 
  our $maximum_wait_time_in_milliseconds = 1000 / $target_tics_per_second;
  our $begin_time;
  our $time_elapsed;
  our $tic_leeway;
  our $which_tic = 0;
  our %client_connections;
# TODO -- and/or accept command line arguments as override



# MAIN GAME LOOP
  our $in = Supplier.new;
  our $incoming = $in.Supply;
  our $out = Supplier.new;
  our $outgoing = $out.Supply;
  our $interpreter = Game::Commands.new;
  start accept_player_commands();

 END GAME LOOP



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
  my $target = 'global';
  unless $which_tic % $ten_tic_seconds {
    if (Int(2.rand)) {
      $target = %client_connections.keys[Int(%client_connections.elems.rand)];
    }
    $out.emit("$target|$ten_tic_seconds tics (10 seconds) have passed");
  }
  if $which_tic == $game_hour {
    $out.emit("global|A game hour ($which_tic tics) has passed");
    $which_tic = 0;
  }
}
