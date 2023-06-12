FROM filebrowser/filebrowser:latest

COPY ./filebrowser_entry.sh /filebrowser_entry.sh
COPY ./filebrowser_runonce.sh /filebrowser_runonce.sh

RUN chmod +x /filebrowser_entry.sh

ENTRYPOINT [ "/filebrowser_entry.sh" ]  