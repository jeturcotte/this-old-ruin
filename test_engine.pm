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



