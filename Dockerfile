# ---- build: компилируем TypeSpec → openapi.json ----
FROM node:24-alpine AS build

WORKDIR /contracts

COPY package.json package-lock.json ./
RUN npm ci

COPY . ./
RUN npx tsp compile .

# ---- runtime: nginx отдаёт статику Scalar ----
FROM nginx:1.27-alpine

COPY docker/nginx.conf /etc/nginx/conf.d/default.conf
COPY web/index.html /usr/share/nginx/html/index.html

# Самодостаточный бандл Scalar (standalone.js, без рантайм-CDN и ленивых чанков)
# и сгенерированные спецификации сервисов.
COPY --from=build /contracts/node_modules/@scalar/api-reference/dist/browser/standalone.js /usr/share/nginx/html/scalar.js
COPY --from=build /contracts/tsp-output/schema/IdentityService.json /usr/share/nginx/html/IdentityService.json
COPY --from=build /contracts/tsp-output/schema/ClientsService.json /usr/share/nginx/html/ClientsService.json
COPY --from=build /contracts/tsp-output/schema/NotificationsService.json /usr/share/nginx/html/NotificationsService.json
COPY --from=build /contracts/tsp-output/schema/AbacService.json /usr/share/nginx/html/AbacService.json
COPY --from=build /contracts/tsp-output/schema/PartnerZonesService.json /usr/share/nginx/html/PartnerZonesService.json
COPY --from=build /contracts/tsp-output/schema/PlaygroundService.json /usr/share/nginx/html/PlaygroundService.json
COPY --from=build /contracts/tsp-output/schema/PositionsService.json /usr/share/nginx/html/PositionsService.json
COPY --from=build /contracts/tsp-output/schema/DiscountsService.json /usr/share/nginx/html/DiscountsService.json

EXPOSE 80
