package controllers;

import play.mvc.Controller;
import play.mvc.Result;

import views.html.*;


public class Application extends Controller {
  
    public static Result index() {
        return ok(index.render());
    }
	public static Result morpion() {
        return ok(morpion.render());
    }
	public static Result life() {
        return ok(life.render());
    }
  
}
