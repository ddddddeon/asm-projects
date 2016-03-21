CC=gcc

c: findBin
	$(CC) -o bin/sc -nostdlib -O0 src/sc.c; \
	sudo chown root bin/sc && sudo chmod u+s bin/sc;

asm: findBin
	$(CC) -o bin/sc -nostdlib -O0 src/sc.s; \
	sudo chown root bin/sc && sudo chmod u+s bin/sc;

hex: 
	@$(CC) -nostdlib -O0 -c src/sc.s; \
	which objdump > /dev/null 2>&1 && objdump -d sc.o && \
	rm sc.o || true;

findBin: unwanted_files
	@[ -d bin ] || mkdir bin

unwanted_files:
	@rm src/*~ src/\#* 2>/dev/null || true
