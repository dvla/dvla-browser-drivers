For testing browsers locally

Run a simple file server and proxy from the top level using: `ruby playground/servers.rb`

Available rake tasks can be found by running:
`bundle exec rake --tasks browser`

Each task will just open the browser and close after a few seconds

## Environment variables

| Variable | Default | Description |
|----------|---------|-------------|
| `BROWSER_URL` | `http://localhost:3000` | URL the browser will open |
| `PROXY_URL` | `http://localhost:8080` | Proxy URL for `proxied` tasks |
| `BROWSER_OPEN_TIME` | `10` | Seconds to hold the browser open |
| `BROWSER_WINDOW_SIZE` | `1337x800` | Window size for `window_size` tasks |
