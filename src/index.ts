import "reflect-metadata";
import { codiac } from "@codiac.io/codiac-api-base";
import { AuthenticationPlugin } from "@codiac.io/plugins-auth-sdk"
import { MongoDbRepoPlugin } from "@codiac.io/plugins-mongo-repo";
import { ValidationPlugin } from "@codiac.io/plugins-validation";

import { myApiDef } from "./myApiDef";
import "@codiac.io/codiac-common/contracts";
import "@codiac.io/codiac-common/security";
import "@codiac.io/codiac-auth-contracts";

codiac
  .addPlugin(AuthenticationPlugin)
  .addPlugin(MongoDbRepoPlugin)
  .addPlugin(ValidationPlugin)
  .run(myApiDef);
        