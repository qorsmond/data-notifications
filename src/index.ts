import { registerPlugin } from '@capacitor/core';

import type { datanotificationPlugin } from './definitions';

const datanotification = registerPlugin<datanotificationPlugin>(
  'datanotification',
  {
    web: () => import('./web').then(m => new m.datanotificationWeb()),
  },
);

export * from './definitions';
export { datanotification };
