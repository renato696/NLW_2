anotações da aula 5: Banco de Dados

sites:
SQLite: sqlite.org
Express: https://expressjs.com/
Nunjucks: https://mozilla.github.io/nunjucks/

Primeiro eu vou na pasta root e crio a pasta database, e crio o arquivo db.js
Então, instalo o sqlite.async com o comando

`npm install sqlite-async``

Uma vez instalado, no arquivo db.js eu preciso importar o sqlite com o comando:

```
const database = require('sqlite-async') 
Database.open(__dirname + /database.sqlite').then(execute)
     function execute(db) {
        db.exec (``
        CREATE TABLE IF NOT EXISTS proffys();
        `)
        }
```

O comando "Database.open(__dirname + /database.sqlite)" cria e abre o arquivo de banco de dados.
Ao chamar a função, vou instruir (exec) o banco de dados a criar as tabelas que eu preciso.

Então, preciso criar as colunas das tabelas:

```
CREATE TABLE IF NOT EXISTS proffys(
id INTEGER PRIMARY KEY AUTOINCREMENT
name.TEXT
avatar.TEXT
);
```

id = identificador primário
INTEGER = número
id INTEGER PRIMARY KEY AUTOINCREMENT = estou criando um número de identificação para cada linha da tabela, deste modo, criando as linhas
name.TEXT... avatar. TEXT = eu crio as colunas que preciso

Então, primeiro eu crio a tabela, depois as linhas (id), depois as colunas.
Para relacionar a tabela 2 com a tabela 1, eu peço na tabela 2, nesse caso, o proffys_id INTEGER, da tabela anterior. Desta forma, além dos dados das colunas
da nova tabela, eu também tenho os dados da linha id da tabela anterior.
Desta forma, eu vou relacionando as tabelas, chamando o id da outra tabela.

dados text vs dados integer??? pesquisar este assunto

Assim que terminar de escrever as tabelas, rodar `node src/database/db.js`, no terminal, e abro o arquivo database.sqlite pelo meno do arquivo.
Com isso, ele abre o SQLite Explorer no menu lateral, onde posso visualizar as tabelas.

Então, eu exporto o arquivo db (o banco de dados) para outros arquivos usando o module.exports:

`module.exports = Database.open(__dirname + '/database.sqlite').then(execute)`

O fluxo de criação fica: requiro o banco de dados "sqlite-async" e coloco em uma variável Database em memória. Pego o Database em memória e abro "open",
criando o arquivo "database.sqlite" e executando ele "execute". Ao executar, eu rodo a função db e crio as tabelas. Após criar as tabelas, exporto o banco
para outro arquivo realizar outra função e.g. "text.js". Ficar atento a ROTA!
Então, lá no test.js eu requiro o arquivo db.js da função anterior colocando ele em uma variável: `const db = require('./db')` . Desta forma ligo o arquivo,
mantendo o fluxo de dados.

O arquivo test.js é para testar o formulário/banco de dados, se os dados estão indo para os lugares corretos nas tabelas.
A inserção de dados no banco de dados será feita pelo arquivo "createProffy.js", onde será feita toda a lógica de programação.

É interessante usar o `await` antes da função para inserir dados em cada tabela para dar tempo ao sistema. Mas para usar o `await`, dentro da função,
eu preciso usar o `async function`. Sem `async` não rola `await`.

O comando SQL para insere valores nas tabelas é "INSERT INTO".

O `map` faz um novo array com o resultado da função e retorna para o próximo valor continuado a inserir no novo array:

````
map ((value) => {x, y, 2...
  returne
  }

[x+1, y+1, 2+1...] por exemplo
````

Pelo que eu entendi, na inserção de dados,pegamos os dados da primeira tabela e colocamos em uma variável. Ai, para inserir os dados da segunda tabela, 
pegamos todos os dados da segunda mais os dados da primeira e colocamos em outra variável. Então, pegamos essa variável e somamos os dados da terceira tabela...
ao final, criamos uma array com todos os dados. Ou seja, a inserção de dados é feita em cascata. Não pego os dados e já insiro mas sim somo e depois insiro 
de uma vez. Cada inserção leva seu próprio tempo, por isso, a necessidade do `await`, uma depois da outra, seguindo a fila, finalizando com o `promisse.all`.
A promessa é a conclusão das somas dos dados na inserção do banco de dados: `await promisse.all (...)` 

Depois eu rodo o test.js para encontrar erros. Se tudo certo, deleto o arquivo database.sqlite, e parto para a inserção real, pois o db está recebendo os dados.

Quando faço a consulta de dados (await db.all()), o banco me retorna os dados salvos no banco de dados em forma de array, com diversos objetos dentro. Na segunda 
pesquisa, o mayk trouxe as aulas do professor e os dados do proffy, isso porque as tabelas estão relacionadas, para ter acesso as informações da segunda tabela,
eu tenho que carregar a primeira junto...

Para fazer a união delas e trazer todas as informações:

```
SELECT classes.*, proffys.*
FROM proffys
JOIN classes ON (classes.proffy_id = proffysid)
WHERE classes.proffy_id = 1 - número de registro
...depois, WHERE EXISTS...
```

PS: `const {sbject, weekday, getSubject} = require ('./utils/format')` desta forma eu já estou desestruturando a variável const em vez de dar um nome a ela 
e depois ter que usar `format.subject`... por exemplo.

É uma boa prática usar o `try catch error`, pois se houver erros no banco de dados é possível saber quais são. No caso de uma falha do promisse, por exemplo.

O fluxo até agora é db.js abre o banco de dados e cria as tabelas, se necessário e retorna o db, que eu pego no arquivo pages.js... ai criamos uma variável
em que ela passa o db pela query `const proffys = await db.all(query)`

Quando eu enviar a pesquisa, preciso preparar o servidor para receber os dados com o comando:
.use(express.urlencoded({extended:true}))

E envio para a função pela rota:
.post ("/save class', saveClasses)

Essa função vai ser feita no arquivo pages.js
function saveClasses(req, res) {
}

E exporto ela no module.exports do page.js
E recupero ela no server na variavel const no ínício.
Me parece que eu tenho que colocar a função separada do arquivo server.js

No HTML (give-classes.html) eu coloco no <form>:

<form action="save-classes" method="post">

ASsim escondo as informações da pesquisa no url.
