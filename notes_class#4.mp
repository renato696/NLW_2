npm init -y = uso esse comando para iniciar novo projeto na pasta. Ele cria o arquivo package.json

npm install express = cria a pasta node_modules e o arquivo package-lock.json

crio o arquivo server.js dentro da pasta src e edito ele com os comandos:

require('express')().listen(5500) = executo essa função para rodar o servidor com o comando no terminal: node src/server.js

o servidor abre a porta 5500, mas não pega a barra "/".... "cannot GET"... não pode pegar rotas.

então, vc requere o express e pede a "/"e chama uma arrow function. assim já dou a rota que ele não encontrava com o "cannot:

require('express')()
.get ("/"), (req, res) => {
  return send (hello world)
  return sendFile (__dirname + "/views/index.html") - para buscar um arquivo .html em determinada subpasta
  res.render(index.html) - sendFile é substituido pelo render após ativar o nunjucks, para que o nunjucks possa editar o html
  
toda vez que eu fizer uma alteração no server.js eu preciso reiniciar ele. finalizo os processos com crtl+C e limpo a tela com crtl+L.
  
npm install nodemon -D  (para reinicialização automática do server.js - instalar toda vez em novo projeto)
  
e editar o arquivo, dentro do "scripts":
  
"scripts" {
   "dev":nodemom src/server.js  - trocar por essas instruções

e executa no terminal o comando: npm run dev

Para ficar mais fácil a configuração do servidor, eu posso colocar ele dentro de uma variável e o express também:

const express = require('express')
const server = express()

server.use(express.static("public") = arquivos estáticos, e.g. imagens, css, no caso, tudo da pasta public

OBS: todo .use é configuração de servidor

Então usa o comando .get para buscar as páginas. Lembrando que no menu do HTML eu preciso remover a extensão .html das páginas nos caminhos antes de reiniciar o servidor

Se eu rodar o node src/server.js pelo terminal, ele vai rodar independente do VSCode.

O HTML não consegue sozinho pegar os dados e inserir nas páginas HTML. Ele só reproduz, não edita. Para editar, eu uso o TEMPLATE ENGINE - NUNJUCKS

npm install nunjucks (instalar toda vez em novo projeto)

Ai, configura o servidor para acessar o nunjucks:

const nunjucks = require('nunjucks')

nunjucks.configure('src/views', {  -onde estão meus arquivos HTML
express = server   -informa qual o servidor usado
noCache = true     -não salva informação na memória cache
})

no HTML eu uso {{ }} para receber dados do nunjucks. Desta forma, a página fica dinâmica. 
Na aula, usou-se a estrutura de repetição com nunjucks:

{{%for%}}
{{%endfor%}}

Quando o usuario faz a selecao, eu uso o req.query para reenviar os dados do filters para a página.
Pega o query armazena na variável filters e usa na página ao retornar ao usuário:

function pageStudy (req, res) {
  const filters = req.query
  return res.render ("study.html" , { proffys, filters})
  
no loop do nunjucks, o padrão é posição 1, se eu quiser pegar na posição 0 do array, uso index0:

<option value="{{loop.index0}}"> .... </option>

OBS DESAFIO: se os dados estiverem completos, chamar a página SUCESSO via server.js... return res.redirect("/sucesso")  ....talvez? =]


