# ToDo Flutter App
### R. Conner Howell - 2018

This is a tutorial ToDo app built with Flutter. It shows off how to interact with a RESTful API, and how to build a Flutter application using the Model, View, Presenter architecture.

## Backend

Check out a Golang backend [here](https://github.com/RCHowell/go-todo-api), or build your own according the API guide show in this readme!

## API Guide
Here are the details on the API this app interacts with.

#### Methods

| Method  | Action  | Response|
| ------- | ------  |      ---| 
| POST    | Create  | 200     |
| GET     | Read    | 200     |
| PUT     | Update  | 200/400 |
| DELETE  | Delete  | 200/400 |

#### Model
```{javascript}
{
  "id": int,      // Time created in ms
  "done": bool,   // Is the TODO marked as done?
  "text": string  // What is there TODO?
}
```