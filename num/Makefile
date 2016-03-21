NAME=num
CC=gcc

asm: findBin
	$(CC) -o bin/$(NAME) -nostdlib -O0 src/$(NAME).s;

hex: 
	@$(CC) -nostdlib -O0 -c src/$(NAME).s; \
	which objdump > /dev/null 2>&1 && objdump -d $(NAME).o && \
	rm $(NAME).o || true;

findBin: unwanted_files
	@[ -d bin ] || mkdir bin

unwanted_files:
	@rm src/*~ src/\#* 2>/dev/null || true
