import Vapor

struct MealsController: RouteCollection {
    func boot(router: Router) throws {
        let mealsRoute = router.grouped("api", "meals")
        mealsRoute.delete(Meal.parameter, use: deleteMealHandler)
        mealsRoute.get(use: getAllHandler)
        mealsRoute.get(Meal.parameter, use: getMealHandler)
        mealsRoute.post(Meal.self, use: createMealHandler)
        mealsRoute.put(Meal.parameter, use: updateMealHandler)
    }
    
    func createMealHandler(_ req: Request, meal: Meal) throws -> Future<Meal> {
        return meal.save(on: req)
    }
    
    func deleteMealHandler(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Meal.self).flatMap(to: HTTPStatus.self) { meal in
            return meal.delete(on: req).transform(to: .noContent)
        }
    }
    
    func getAllHandler(_ req: Request) throws -> Future<[Meal]> {
        return Meal.query(on: req).all()
    }
    
    func getMealHandler(_ req: Request) throws -> Future<Meal> {
        return try req.parameters.next(Meal.self)
    }
    
    func updateMealHandler(_ req: Request) throws -> Future<Meal> {
        return try flatMap(
            to: Meal.self,
            req.parameters.next(Meal.self),
            req.content.decode(Meal.self)
        ) { meal, updatedMeal in
            meal.name = updatedMeal.name
            meal.price = updatedMeal.price
            return meal.save(on: req)
        }
    }
}
