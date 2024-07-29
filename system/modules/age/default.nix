{ ... }: {
  age = {
    secrets = {
      xray.file = ../../../secrets/xray.age;
    };

    identityPaths = [ "/root/.ssh/secrets" ];
  };
}
