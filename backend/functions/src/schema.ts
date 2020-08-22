import { User, Product, Shop, ProductShopInventoryLink } from './services/services'

export { typeDefs } from './services/typeDefs'

/*
params: {
  methods: ["get", "getMultiple", "delete", "update", "add"]
}
*/

export const rootResolvers = {
  query: {
    getMyUsers: {
      method: "get",
      route: "/myUsers",
      resolver: (req) => User.paginator.getRecord(req, {
        ...req.params,
        ...req.jql?.__args,
        created_by: req.user.id,
      }, req.jql)
    },
    upsertProductShopInventoryLink: {
      method: "post",
      route: "/upsertProductShopInventoryLink",
      resolver: (req) => ProductShopInventoryLink.upsertRecord(req, {
        ...req.params,
        ...req.jql?.__args,
      }, req.jql)
    }
  },
  mutation: {},
  subscription: {},
}

function generateRootResolvers(service: any, params: any) {
  const capitalizedClass = service.__typename.charAt(0).toUpperCase() + service.__typename.slice(1);

  params.methods.forEach((method) => {
    const capitalizedMethod = method.charAt(0).toUpperCase() + method.slice(1);
    switch(method) {
      case "get":
        rootResolvers.query[method + capitalizedClass] = {
          method: "get",
          route: "/" + service.__typename + "/:id",
          resolver: (req) => service.getRecord(req, {
            ...req.query,
            ...req.params,
            ...req.jql?.__args
          }, req.jql)
        }
        break;
      case "getMultiple":
        rootResolvers.query[method + capitalizedClass] = {
          method: "get",
          route: "/" + service.__typename,
          resolver: (req) => service.paginator.getRecord(req, {
            ...req.query,
            ...req.params,
            ...req.jql?.__args
          }, req.jql)
        }
        break;
      case "delete":
        rootResolvers.mutation[method + capitalizedClass] = {
          method: "delete",
          route: "/" + service.__typename + "/:id",
          resolver: (req) => service.deleteRecord(req, {
            ...req.params,
            ...req.jql?.__args
          }, req.jql)
        }
        break;
      case "update":
        rootResolvers.mutation[method + capitalizedClass] = {
          method: "put",
          route: "/" + service.__typename + "/:id",
          resolver: (req) => service.updateRecord(req, {
            ...req.body,
            ...req.params,
            ...req.jql?.__args
          }, req.jql)
        }
        break;
      case "add":
        rootResolvers.mutation[method + capitalizedClass] = {
          method: "post",
          route: "/" + service.__typename,
          resolver: (req) => service.addRecord(req, {
            ...req.body,
            ...req.params,
            ...req.jql?.__args
          }, req.jql)
        }
        break;
      case "added":
        rootResolvers.subscription[service.__typename + capitalizedMethod] = {
          method: "post",
          route: "/subscribe/" + service.__typename + capitalizedMethod,
          resolver: (req) => service.subscribeToMultipleItem(service.__typename + capitalizedMethod, req, {
            ...req.params,
            ...req.jql?.__args,
          }, req.jql)
        }
        break;
      case "deleted":
        rootResolvers.subscription[service.__typename + capitalizedMethod] = {
          method: "post",
          route: "/subscribe/" + service.__typename + capitalizedMethod,
          resolver: (req) => service.subscribeToSingleItem(service.__typename + capitalizedMethod, req, {
            ...req.params,
            ...req.jql?.__args,
          }, req.jql)
        }
        break;
      case "updated":
        rootResolvers.subscription[service.__typename + capitalizedMethod] = {
          method: "post",
          route: "/subscribe/" + service.__typename + capitalizedMethod,
          resolver: (req) => service.subscribeToSingleItem(service.__typename + capitalizedMethod, req, {
            ...req.params,
            ...req.jql?.__args,
          }, req.jql)
        }
        break;
    }
  });
};

generateRootResolvers(User, {
  methods: ["get", "getMultiple", "delete", "update", "add"]
});

generateRootResolvers(Product, {
  methods: ["get", "getMultiple", "delete", "update", "add", "added", "updated", "deleted"]
});

generateRootResolvers(Shop, {
  methods: ["get", "getMultiple", "delete", "update", "add"]
});

generateRootResolvers(ProductShopInventoryLink, {
  methods: ["get", "getMultiple", "delete", "update", "add"]
});

export const allRootResolvers = {};

for(const resolverType in rootResolvers) {
  for(const prop in rootResolvers[resolverType]) {
    allRootResolvers[prop] = rootResolvers[resolverType][prop];
  }
}

export function generateSchema() {
  const output = {
    query: {},
    mutation: {},
    subscription: {},
  };

  /*
  for(const resolverType in rootResolvers) {
    for(const prop in rootResolvers[resolverType]) {

    }
  }
  */
  return output;
};
/*
const abc = {
  query: {
    getCompany: {
      returnType: {
        typename: Company.__typename,
        isArray: true,
        required: true
      },
      args: {
        id: { typename: "ID", required: true}
      },
    },
    getMultipleCompany: {
      typename: [Company.__typename],
      args: {
        id: { typename: "ID", required: true}
      },
    }

  },
  mutation: {},
  subscription: {},
};
*/