FROM dart:3.11.5 AS build

WORKDIR /app

COPY pubspec.* ./
RUN dart pub get

COPY . .
RUN dart compile exe bin/server.dart -o /app/server

FROM debian:bookworm-slim

WORKDIR /app

COPY --from=build /app/server /app/server

ENV PORT=8080
EXPOSE 8080

CMD ["/app/server"]
