BIN=../bin
TMP=../tmp
BIN_NAME="main"


SRC_DIR=src

run: out
	./bin/main

out:
	(cd $(SRC_DIR) && ghc -o $(BIN)/$(BIN_NAME) -hidir $(TMP) -tmpdir $(TMP) -odir $(TMP) Main.hs)