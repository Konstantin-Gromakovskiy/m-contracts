import { readdirSync } from 'node:fs'
import { spawn } from 'node:child_process'
import { join } from 'node:path'


const schemaDir = "tsp-output/schema"
const fileNames = readdirSync(schemaDir).toSorted()

const mountCommand = fileNames.map((fileName) => `--mount=/${fileName}:${join(schemaDir, fileName)}`)

const liveServer = spawn(
  "live-server",
  [
    ".",
    "--entry-file=web/index.html",
    `--port=${process.env.SCALAR_PORT ?? "8081"}`,
    "--ignore=node_modules/**",
    ...mountCommand,
    "--mount=/scalar.js:node_modules/@scalar/api-reference/dist/browser/standalone.js",
  ],
  { stdio: "inherit",   
      shell: process.platform === "win32"},
);

liveServer.on("error", (err) => {
  console.log(err)
  process.exit(1)
});
liveServer.on('exit', (code) => process.exit(code ?? 1));


