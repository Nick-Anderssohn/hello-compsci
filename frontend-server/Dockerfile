FROM golang:alpine
EXPOSE 80
EXPOSE 8079
WORKDIR src
RUN mkdir hello-class
RUN mkdir hello-class/frontend-server
WORKDIR hello-class/frontend-server
COPY . .
# CMD ./frontend-server
RUN go install
CMD frontend-server