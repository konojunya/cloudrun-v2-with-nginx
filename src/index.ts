import {serve} from '@hono/node-server';
import {Hono} from 'hono';

const PORT = Number(process.env.PORT) || 8080;

const app = new Hono();
app.get('/', c => c.text('Hello Hono!'));

serve(
  {
    fetch: app.fetch,
    port: PORT,
  },
  info => {
    console.log(`Listening on http://localhost:${info.port}`);
  }
);
