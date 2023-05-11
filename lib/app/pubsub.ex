defmodule PubAndSub do
  # Subs are registry with duplicate key with key is topic
  require Logger

  def create_sub(topic, sub_id) do
    Registry.register(PubSub.Registry, topic, sub_id)
  end

  def send_hello(topic) do
    Registry.dispatch(PubSub.Registry, topic, fn entries ->
      for {pid, {module, function}} <- entries do
        try do
          send(pid, {:broadcast, "Hello, world!"})
        catch
          kind, reason ->
            formatted = Exception.format(kind, reason, __STACKTRACE__)
            Logger.error("Registry.dispatch/3 failed with #{formatted}")
        end
      end
    end)
  end


end
