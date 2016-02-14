# this module/class encompasses the command interpreter responsible for parsing the input from players

class Game::Commands {

  method Normalize($command) { 
    return $command.decode('UTF-8').chomp.uc;
  }

} 
