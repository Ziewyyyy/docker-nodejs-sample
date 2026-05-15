# ========================================
# Base Dependencies
# ========================================
FROM node:20-alpine AS build-deps

WORKDIR /app

COPY package*.json ./

RUN npm install

# ========================================
# Development Stage
# ========================================
FROM build-deps AS development

ENV NODE_ENV=development

COPY . .

EXPOSE 3000 5173 9229

CMD ["npm", "run", "dev"]

# ========================================
# Test Stage
# ========================================
FROM build-deps AS test

ENV NODE_ENV=test

COPY . .

CMD ["npm", "test"]

# ========================================
# Production Stage
# ========================================
FROM node:20-alpine AS production

WORKDIR /app

COPY package*.json ./

RUN npm install --omit=dev

COPY . .

EXPOSE 3000

CMD ["npm", "start"]
