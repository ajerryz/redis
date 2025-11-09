package main

import (
	"context"

	"github.com/go-redis/redis/v8"
)

func main() {
	client := redis.NewClient(&redis.Options{
		Addr:     "localhost:6379",
		DB:       0,
		Username: "",
		Password: "",
	})

	if err := client.Set(context.Background(), "name", "zs", 0).Err(); err != nil {
		panic(err)
	}

	val, err := client.Get(context.Background(), "name").Result()
}
