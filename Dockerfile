# Build
FROM node:20-bookworm as builder

WORKDIR /app

COPY . .

RUN npm ci
RUN npm run build

# Production
FROM node:20-bookworm

WORKDIR /app

COPY --from=builder --chown=node:node /app/.output  .

ENV NODE_ENV production
ENV NUXT_ENVIRONMENT production

ENV NITRO_HOST 0.0.0.0
ENV NITRO_PORT 8080

EXPOSE 8080

USER node:node

ENTRYPOINT ["node"]
CMD ["/app/server/index.mjs"]
