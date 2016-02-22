# this module/class encompasses the command interpreter responsible for parsing the input from players

class Game::Commands {

  method Normalize($command) { 
    return $command.decode('UTF-8').chomp.uc;
  }

  # I feel like this will mutate into the event class in the adventure thing by masak
  # let's at least try to do it different at first
  # problem being, I'd rather have methods attached to each primary command
  # rather than a switch case... 
  # further, it has no access here to game information... so thats going to change soon
  method Respond($command) {

    my @particles = $command.split(" ");
    say "interpreting: " ~ @particles.join(", ");
    given @particles[0] {
      when "WHO" { return "PFF.  WHO?  Mind your business!\n"; }
      when "LOOK" { return "Well... you looked.  Nuff Said!\n"; }
      default { return "Huh?\n";i }
    }    

  }

} 
