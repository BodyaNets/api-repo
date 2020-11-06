import "reflect-metadata"
import { apiDef, apiHost } from "@codiac.io/codiac-api-base";
import { Shoe, shoeCriteria } from "./models/shoe";

export class myApiDef extends apiDef {

    /**
     *
     */
    constructor() {
        super();

    }

    defineEndpoints(host: apiHost): void {
      // ----TEMP--------------------
      let openApi = this.endpoints.find(e => e.operationId == "openApi");
      if (openApi) openApi.isDmz = true;

      this.addCrudsFor(Shoe, shoeCriteria, '/shoes');
      // ----TEMP--------------------


    }

    Bootstrap(host: apiHost): void {
       this.useMongoDb('BohdanTest');
    }
}