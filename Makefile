CFLAGS = -msse2 --std gnu99 -O0 -Wall -Wextra

GIT_HOOKS := .git/hooks/applied

all: $(GIT_HOOKS) main.c
	$(CC) $(CFLAGS) -DSSEPREFETCH -DSSE -DNAIVE -o main main.c

allsp: $(GIT_HOOKS) main.c
	$(CC) $(CFLAGS) -DSSEPREFETCH  -o sse_prefetch main.c
	$(CC) $(CFLAGS) -DSSE -o sse main.c
	$(CC) $(CFLAGS) -DNAIVE -o naive main.c

$(GIT_HOOKS):
	@scripts/install-git-hooks
	@echo

tofile: allsp
	rm -f data.txt
	./naive done >> data.txt 
	./sse done >> data.txt
	./sse_prefetch done >> data.txt

clean:
	$(RM) main sse_prefetch sse naive data.txt
