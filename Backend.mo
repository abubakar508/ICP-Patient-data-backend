// logistics_backend.mo

import Prim "mo:prim";
import Shared "shared.mo";

actor LogisticsBackend {

  // Define a record to represent a package
  type Package = {
    id: Text;
    status: Shared.Status;
  };

  // Initialize an empty map to store packages
  var packages: Prim.HashMap.Text<Package> = Prim.HashMap.empty<Text, Package>();

  // Function to add a new package
  public shared(Package) func addPackage(id: Text): async Package {
    let newPackage = { id = id; status = Shared.Status.InTransit };
    packages[id] := newPackage;
    newPackage;
  };

  // Function to get the status of a package
  public shared(Shared.Status) func getPackageStatus(id: Text): async Shared.Status {
    switch (packages[id]) {
      null => Shared.Status.NotFound,
      some(package) => package.status;
    };
  };

  // Function to update the status of a package
  public shared(Shared.Status) func updatePackageStatus(id: Text, newStatus: Shared.Status): async Shared.Status {
    switch (packages[id]) {
      null => Shared.Status.NotFound,
      some(package) => {
        packages[id].status := newStatus;
        newStatus;
      };
    };
  };

};
