//
//  Configurations.swift
//
//  Created by Денис Кожухарь on 11.08.2022.
//  Copyright © 2022 Spider Group. All rights reserved.
//

import DITranquillity
import RouteComposer

enum ScreenConfigurations {}

extension ScreenConfigurations {
    static func mainTabBarStep() -> Destination<
        MainTabBarControllerFactory.ViewController,
        MainTabBarControllerFactory.Context
    > {
        Destination(
            to: StepAssembly(
                finder: ClassFinder(),
                factory: MainTabBarControllerFactory()
            )
            .using(GeneralAction.replaceRoot(animationOptions: [.transitionCrossDissolve]))
            .from(GeneralStep.root())
            .assemble()
        )
    }
}
