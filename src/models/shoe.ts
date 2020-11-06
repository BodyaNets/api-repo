import { IDomainEntity, thanksTypescript } from "@codiac.io/codiac-common";
import { CriteriaBase, StringFilter } from "@codiac.io/codiac-common/contracts";

export class Shoe implements IDomainEntity {
    constructor(public size: number, public brand: string, public model: string, id?: string) {
        this.id = id;
    }

    id: string | undefined;
}

export class shoeCriteria extends CriteriaBase<Shoe> { 
    @thanksTypescript public size?: number;
    @thanksTypescript public brand?: StringFilter;
    @thanksTypescript public model?: string;
}