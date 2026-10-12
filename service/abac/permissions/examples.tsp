import "./models.tsp";

const PermissionsExamples = #{
  returnType: #{
    statusCode: 200,
    body: #{
      body: #[
        #{
          id: "56bc7cf1-3b50-4785-ac56-b4fe8bd84c0c",
          code: #{
            domain: "partner",
            category: "profile",
            group: "notifications",
            type: AbacService.Permissions.PermissionType.View,
          },
        },
        #{
          id: "56bc7cf1-3b50-4785-ac56-b4fe8bd84c01",
          code: #{
            domain: "partner",
            category: "profile",
            group: "notifications",
            type: AbacService.Permissions.PermissionType.Update,
          },
        },
        #{
          id: "56bc7cf1-3b50-4785-ac56-b4fe8bd84c02",
          code: #{
            domain: "partner",
            category: "content",
            group: "bases",
            type: AbacService.Permissions.PermissionType.View,
          },
        },
        #{
          id: "56bc7cf1-3b50-4785-ac56-b4fe8bd84c03",
          code: #{
            domain: "partner",
            category: "content",
            group: "bases",
            type: AbacService.Permissions.PermissionType.Create,
          },
        },
        #{
          id: "56bc7cf1-3b50-4785-ac56-b4fe8bd84c04",
          code: #{
            domain: "partner",
            category: "calendar",
            group: "order_reserve_client",
            type: AbacService.Permissions.PermissionType.Update,
          },
        },
        #{
          id: "56bc7cf1-3b50-4785-ac56-b4fe8bd84c05",
          code: #{
            domain: "partner",
            category: "calendar",
            group: "order_reserve_promo",
            type: AbacService.Permissions.PermissionType.Update,
          },
        },
      ],
      meta: #{
        message: #{
          code: 1010112,
          params: #{},
        },
      },
    },
  },
};
