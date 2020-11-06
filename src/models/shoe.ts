import { IDomainEntity } from "@codiac.io/codiac-common";
import { CriteriaBase } from "@codiac.io/codiac-common/contracts";

export class Shoe implements IDomainEntity {
    constructor(public size: number, public brand: string, public model: string, id?: string) {
        this.id = id;
    }

    id: string | undefined;
}

export class shoeCriteria extends CriteriaBase<Shoe> { 
    public size?: number;
    public brand?: string;
    public model?: string;
}