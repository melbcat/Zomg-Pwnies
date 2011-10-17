BUILD=nasm -I ../linux/ minishell.asm

all: minishell

minishell:
	$(BUILD)

verbose:
	$(BUILD) -D VERBOSE

.PHONY: clean
clean:
	rm -f minishell