export interface datanotificationPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
