import { ApiPromise, WsProvider } from '@polkadot/api';
import pkg from 'pg';

const client = new pkg.Client({
    user: 'postgres',
    host: 'db',
    database: 'app',
    password: 'postgres',
    port: 5432,
})

await client.connect()

const wsProvider = new WsProvider('wss://v4-prod-collator-01.mangatafinance.cloud');
const api = await ApiPromise.create({ provider: wsProvider });

api.derive.chain.subscribeNewHeads(async (header) => {
    console.log(`${header.hash.toString()}: ${header.author}`);

    let date = new Date();

    await client.query('BEGIN')
    const queryText = 'INSERT INTO blocks(block_hash, author, inserted_at, updated_at) VALUES($1, $2, $3, $4)'
    const queryValues = [header.hash.toString(), header.author.toString(), date.toUTCString(), date.toUTCString()]
    await client.query(queryText, queryValues)
    await client.query('COMMIT')

    client
      .query('SELECT * FROM blocks')
      .then(res => console.log(res))
      .catch(e => console.error(e.stack))
});