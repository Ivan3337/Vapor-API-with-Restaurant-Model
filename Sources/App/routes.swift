import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    let mealsController = MealsController()
    try router.register(collection: mealsController)
}
