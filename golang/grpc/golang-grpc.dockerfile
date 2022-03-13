FROM gitpod/workspace-go

RUN sudo apt install -y protobuf-compiler
RUN export PATH="$PATH:$(go env GOPATH)/bin"
