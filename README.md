# Kobana Pix Ruby

## Instalação

Adicione a linha a baixo no seu Gemfile:

    gem 'kobana-pix-ruby'

Execute:

    $ bundle install

Ou instale você mesmo:

    $ gem install kobana-pix-ruby

## Configuração

Saiba mais sobre o [Token de API ](https://developers.kobana.com.br/reference/token-de-acesso)

```ruby
require 'kobana-pix-ruby'

Kobana.configure do |c|
  c.environment = :production # defaut :sandbox
  c.api_key = 'api-token'
end
```

## Exemplos

### Pix

```ruby
# Criar um pix

begin
  @pix = Kobana.pix.create(
    pix_account_id: 1,
    amount: 120.99,
    expire_at: '2023-12-02T10:03:56-03:00',
    additional_info: {'extra key': 'extra value'},
    message: 'Mensagem')
rescue Kobana::Error => e
  puts e.body
  puts e.status
  puts e.errors
end

# Visualizar um pix

begin
  @pix = Kobana.pix.find(1)
rescue Kobana::Error => e
  puts e.body
  puts e.status
  puts e.error_message
end
```
