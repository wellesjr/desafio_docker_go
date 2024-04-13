# Use a imagem oficial do Go como imagem base
FROM golang:1.16 as builder

# Defina o diretório de trabalho no contêiner
WORKDIR /app

# Copie o código Go para o contêiner
COPY main.go .

# Compile o código Go
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

# Inicie uma nova etapa de construção
FROM scratch

# Copie o executável para a imagem
COPY --from=builder /app/main /

# Execute o programa
CMD ["/main"]