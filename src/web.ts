import { WebPlugin } from '@capacitor/core';

import type { datanotificationPlugin } from './definitions';

export class datanotificationWeb
  extends WebPlugin
  implements datanotificationPlugin {

  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }

  onDataMessage(options: any): Promise<any> {
    console.log('onDataMessage', options);
    throw new Error('Method not implemented.');
  }
}
