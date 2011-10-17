#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<dlfcn.h>
#include<stdio.h>
#include<unistd.h>
#include<sys/socket.h>
#include<netinet/in.h>

const char *WELCOME = "You output to my input? Do your best!\n";
const char *REPLY   = "Is this your best?:\n";

char global_client_buffer[4096];

void read_from_client (int sock) {
  char buf[200], c, stop = '\n';
  int i = 0;
  memset(buf, 0, sizeof(buf));
  write(sock, WELCOME, strlen(WELCOME));
  while (read(sock, &c, 1)) {
    buf[i++] = c;
    if (c == stop)
      break;
  }
  memcpy(global_client_buffer, buf, strlen(buf));
}

void write_to_client (int sock) {
  write(sock, REPLY, strlen(REPLY));
  write(sock, global_client_buffer, strlen(global_client_buffer));
}

void handle_client (int sock) {
  read_from_client(sock);
  write_to_client(sock);
  close(sock);
}

int main (int argc, char **argv) {
  unsigned short int port;
  struct sockaddr_in saddr, caddr;
  int sock, nsock, nsocklen;

  if (argc < 2) {
    printf("Usage: %s port", argv[0]);
    return 0;
  }
  port = atoi(argv[1]);

  saddr.sin_family = AF_INET;
  saddr.sin_port = htons(port);
  saddr.sin_addr.s_addr = INADDR_ANY;

  sock = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
  bind(sock, (struct sockaddr *)&saddr, sizeof(saddr));
  listen(sock, 1);

  nsocklen = sizeof(caddr);
  for (;;) {
    nsock = accept(sock, (struct sockaddr *)&caddr, &nsocklen);
    printf("Got connection from %d.%d.%d.%d\n",
           ((caddr.sin_addr.s_addr      ) & 0xFF),
           ((caddr.sin_addr.s_addr >>  8) & 0xFF),
           ((caddr.sin_addr.s_addr >> 16) & 0xFF),
           ((caddr.sin_addr.s_addr >> 24) & 0xFF)
           );
    if (fork() == 0) {
      close(sock);
      handle_client(nsock);
      printf("Clean exit\n");
      exit(0);
    }
    else
      close(nsock);
  }

  return 0;
}