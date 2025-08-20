darwin run_blueprint --mode folder build/ amalgamation_build
gcc release/amalgamation.c  -o darwin2
sudo mv darwin2 /usr/local/bin/darwin2