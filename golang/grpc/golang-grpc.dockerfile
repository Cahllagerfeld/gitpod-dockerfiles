FROM gitpod/gitpod/workspace-go

RUN sudo apt install -y protobuf-compiler
RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
RUN go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.1
RUN export PATH="$PATH:$(go env GOPATH)/bin"
