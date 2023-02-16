const express = require('express')
const { exec } = require('child_process');
const app = express()
const port = 4000

app.get('/', (req, res) => {
  exec('powershell -f ./scripts/connect.ps1', {'shell':'powershell.exe'}, (error, stdout, stderr)=> {
	res.send(JSON.stringify({
		error,
		stdout,
		stderr
	}))
  })
})

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})
