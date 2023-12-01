import {serve} from '@hono/node-server';
import {Hono} from 'hono';

const PORT = Number(process.env.PORT) || 8888;

const app = new Hono();
app.get('/', c => c.text('Hello Hono!'));

serve(
  {
    fetch: app.fetch,
    port: PORT,
    hostname: '0.0.0.0',
  },
  info => {
    console.log(`Listening on http://localhost:${info.port}`);
  }
);
