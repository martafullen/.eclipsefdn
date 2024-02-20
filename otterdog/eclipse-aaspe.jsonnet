local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('eclipse-aaspe') {
  settings+: {
    dependabot_security_updates_enabled_for_new_repositories: false,
    description: "",
    name: "Eclipse AASX Package Explorer",
    packages_containers_internal: false,
    packages_containers_public: false,
    readers_can_create_discussions: true,
    two_factor_requirement: false,
    web_commit_signoff_required: false,
    workflows+: {
      actions_can_approve_pull_request_reviews: false,
      default_workflow_permissions: "write",
    },
  },
  _repositories+:: [
    orgs.newRepo('aaspe') {
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      description: "AASX Package Explorer",
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
      secrets: [
        orgs.newRepoSecret('SECRET1') {
          value: "********",
        },
      ],
    },
    orgs.newRepo('aaspe-V2') {
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      dependabot_alerts_enabled: false,
      description: "AASX V2 Package Explorer",
      secret_scanning: "disabled",
      secret_scanning_push_protection: "disabled",
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
    },
    orgs.newRepo('aasx-server') {
      allow_rebase_merge: false,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      description: "C# based server for AASX packages",
      homepage: "",
      secret_scanning: "disabled",
      secret_scanning_push_protection: "disabled",
      topics+: [
        "aasx",
        "aasx-server",
        "administration-shell",
        "asset-administration-shell",
        "industrie-40",
        "industrie40"
      ],
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
      webhooks: [
        orgs.newRepoWebhook('https://cla-assistant.io/github/webhook/aasx-server') {
          content_type: "json",
          events+: [
            "pull_request"
          ],
        },
      ],
      secrets: [
        orgs.newRepoSecret('DOCKERHUB_PASSWORD') {
          value: "********",
        },
      ],
      branch_protection_rules: [
        orgs.newBranchProtectionRule('master') {
          required_approving_review_count: null,
          required_status_checks+: [
            "any:Check-release",
            "any:Check-style"
          ],
          requires_pull_request: false,
        },
      ],
    },
  ],
}
