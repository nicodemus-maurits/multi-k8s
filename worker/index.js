const keys = require('./keys')
const redis = require('redis')

const redisClient = redis.createClient({
    host: keys.redisHost,
    port: keys.redisPort,
    //In case of failure, retry connection after 1 second
    retry_strategy: () => 1000
})
const subscription = redisClient.duplicate()

const fib = index => {
    if(index < 2) return 1
    return fib(index - 1) + fib(index - 2)
}

subscription.on('message', (channel, message) => {
    redisClient.hset('values', message, fib(parseInt(message)))
})

subscription.subscribe('insert')
