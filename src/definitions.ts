import { PluginListenerHandle } from "@capacitor/core";

export interface datanotificationPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
  // onDataMessage(options: any): Promise<any>;

  addListener(
    eventName: 'message',
    listenerFunc: (message: any) => void,
  ): Promise<PluginListenerHandle> & PluginListenerHandle;

  removeAllListeners(): Promise<void>;
}
